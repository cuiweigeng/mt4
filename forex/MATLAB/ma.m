function [ret] = ma(in, len, win)

ma(1:len) = 0;
for idx=win:len
    ma(idx) = mean(in(idx-win+1:idx));
end
ma(1:win-1) = ma(win);
ret = ma;