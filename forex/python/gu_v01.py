# v01

from __future__ import print_function

import tensorflow as tf
from tensorflow.python.ops import rnn, rnn_cell
from tensorflow.contrib.learn.python.learn.datasets import base
from tensorflow.python.framework import dtypes
from six.moves import xrange

import numpy
import pdb
import array
import struct
import collections

class DataSet(object):

  def __init__(self,
               images,
               labels,
               fake_data=False,
               one_hot=False,
               dtype=dtypes.float32,
               reshape=True):
    """构造一个数据集
    one_hot 参数仅用于fake_data为真。'dtype'可以是'uint8'对应输入[0,255],
    也可以是'float32'，对应归一化后的输入[0,1]
    """

    dtype = dtypes.as_dtype(dtype).base_dtype
    if dtype not in (dtypes.uint8, dtypes.float32):
      raise TypeError('Invalid image dtype %r, expected uint8 or float32' %
                      dtype)
    assert images.shape[0] == labels.shape[0], (
        'images.shape: %s labels.shape: %s' % (images.shape, labels.shape))
    self._num_examples = images.shape[0]

    # Convert shape from [num examples, n_rows, columns, depth]
    # to [num examples, n_rows*columns] (assuming depth == 1)
    if reshape:
      assert images.shape[3] == 1
      images = images.reshape(images.shape[0],
                              images.shape[1] * images.shape[2])
    if dtype == dtypes.float32:
      # Convert from [0, 255] -> [0.0, 1.0].
      images = images.astype(numpy.float32)
      images = numpy.multiply(images, 1.0 / 2147483647.0)
	  
    self._images = images
    self._labels = labels
    self._epochs_completed = 0
    self._index_in_epoch = 0

  @property
  def images(self):
    return self._images

  @property
  def labels(self):
    return self._labels

  @property
  def num_examples(self):
    return self._num_examples

  @property
  def epochs_completed(self):
    return self._epochs_completed

  def next_batch(self, batch_size):
    start = self._index_in_epoch
    self._index_in_epoch += batch_size
    if self._index_in_epoch > self._num_examples:
      # Finished epoch
      self._epochs_completed += 1
      # Shuffle the data
      perm = numpy.arange(self._num_examples)
      numpy.random.shuffle(perm)
      self._images = self._images[perm]
      self._labels = self._labels[perm]
      # Start next epoch
      start = 0
      self._index_in_epoch = batch_size
      assert batch_size <= self._num_examples
    end = self._index_in_epoch
    return self._images[start:end], self._labels[start:end]

	
def _read32(bytestream):
  dt = numpy.dtype(numpy.uint32).newbyteorder('>')
  return numpy.frombuffer(bytestream.read(4), dtype=dt)[0]	

def dense_to_one_hot(labels_dense, num_classes):
  num_labels = labels_dense.shape[0]
  index_offset = numpy.arange(num_labels) * num_classes
  labels_one_hot = numpy.zeros((num_labels, num_classes))
  labels_one_hot.flat[index_offset + labels_dense.ravel()] = 1
  return labels_one_hot
  
def extract_images(f): 
  num_images = _read32(f)
  rows = 5;
  cols = 1;

  buf = []
  count = 0;
  while (count < num_images*rows*cols):
    buf.append(_read32(f))
    count = count + 1
  data = numpy.array(buf)
  data = data.reshape(num_images, rows, cols, 1)
  return data
	
def extract_labels(f, one_hot=False, num_classes=3):
  num_items = _read32(f)
  buf = f.read(num_items)
  labels = numpy.frombuffer(buf, dtype=numpy.uint8)
  if one_hot:
    return dense_to_one_hot(labels, num_classes)
  return labels

Datasets = collections.namedtuple('Datasets', ['train', 'test'])	
def read_data(train_dir,
              one_hot=False,
              dtype=dtypes.float32,
              reshape=True):				   
  with open(train_dir + 'trainImages', 'rb') as f:
    train_images = extract_images(f)

  with open(train_dir + 'trainLabels', 'rb') as f:
    train_labels = extract_labels(f, one_hot=one_hot)

  with open(train_dir + 'testImages', 'rb') as f:
    test_images = extract_images(f)

  with open(train_dir + 'testLabels', 'rb') as f:
    test_labels = extract_labels(f, one_hot=one_hot)

  train = DataSet(train_images, train_labels, dtype=dtype, reshape=reshape)
  test = DataSet(test_images, test_labels, dtype=dtype, reshape=reshape)

  return Datasets(train=train, test=test)
  
  
  
  
'''
To classify using a recurrent neural network
'''  
  
# pdb.set_trace() 
# print(forex.train.labels[0])
forex = read_data("../MATLAB/", one_hot=True) 

# Parameters
learning_rate = 0.001
training_iters = 100000
batch_size = 120
display_step = 100

# Network Parameters
n_input = 1 # MNIST data input (img shape: 28*28)
n_steps = 5 # timesteps
n_hidden = 120 # hidden layer num of features
n_classes = 3 # MNIST total classes (0-9 digits)

# tf Graph input
x = tf.placeholder("float", [None, n_steps, n_input])
y = tf.placeholder("float", [None, n_classes])

# Define weights
weights = {
    'out': tf.Variable(tf.random_normal([n_hidden, n_classes]))
}
biases = {
    'out': tf.Variable(tf.random_normal([n_classes]))
}

def RNN(x, weights, biases):

    # Prepare data shape to match `rnn` function requirements
    # Current data input shape: (batch_size, n_steps, n_input)
    # Required shape: 'n_steps' tensors list of shape (batch_size, n_input)

    # Permuting batch_size and n_steps
    x = tf.transpose(x, [1, 0, 2])
    # Reshaping to (n_steps*batch_size, n_input)
    x = tf.reshape(x, [-1, n_input])
    # Split to get a list of 'n_steps' tensors of shape (batch_size, n_input)
    x = tf.split(0, n_steps, x)

    # Define a lstm cell with tensorflow
    lstm_cell = rnn_cell.BasicLSTMCell(n_hidden, forget_bias=1.0)

    # Get lstm cell output
    outputs, states = rnn.rnn(lstm_cell, x, dtype=tf.float32)

    # Linear activation, using rnn inner loop last output
    return tf.matmul(outputs[-1], weights['out']) + biases['out']

pred = RNN(x, weights, biases)

# Define loss and optimizer
cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(pred, y))
optimizer = tf.train.AdamOptimizer(learning_rate=learning_rate).minimize(cost)

# Evaluate model
correct_pred = tf.equal(tf.argmax(pred,1), tf.argmax(y,1))
accuracy = tf.reduce_mean(tf.cast(correct_pred, tf.float32))

# Initializing the variables
init = tf.global_variables_initializer()

# Creat Saver
saver = tf.train.Saver()

# Launch the graph
with tf.Session() as sess:
    sess.run(init)
    step = 1
    # Keep training until reach max iterations
    while step * batch_size < training_iters:
        batch_x, batch_y = forex.train.next_batch(batch_size)
        # Reshape data to get 28 seq of 28 elements
        batch_x = batch_x.reshape((batch_size, n_steps, n_input))
        # Run optimization op (backprop)
        sess.run(optimizer, feed_dict={x: batch_x, y: batch_y})
        if step % display_step == 0:
            # Calculate batch accuracy
            acc = sess.run(accuracy, feed_dict={x: batch_x, y: batch_y})
            # Calculate batch loss
            loss = sess.run(cost, feed_dict={x: batch_x, y: batch_y})
            print("Iter " + str(step*batch_size) + ", Minibatch Loss= " + \
                  "{:.6f}".format(loss) + ", Training Accuracy= " + \
                  "{:.5f}".format(acc))
        step += 1
    print("Optimization Finished!")

    # Calculate accuracy for 128 forex test images
    #test_len = 6000
    #test_data = forex.test.images[:test_len-1].reshape((-1, n_steps, n_input))
    #test_label = forex.test.labels[:test_len-1]
    #print("Testing Accuracy:", \
    #    sess.run(accuracy, feed_dict={x: test_data, y: test_label}))
    
    #pdb.set_trace()	
    f=open('../MATLAB/result.txt','w')
    f2=open('../MATLAB/result2.txt','w')
    for i in range(0, 6000):	
        test_data = forex.test.images[i].reshape((-1, n_steps, n_input))	
        test_label = forex.test.labels[i].reshape((-1, 3))	
        result = sess.run(pred, feed_dict={x: test_data})
        f.write(str(result)+'\n')
        result = sess.run(accuracy, feed_dict={x: test_data, y: test_label})
        f2.write(str(result)+'\n')
    f.close()	
    f2.close()		