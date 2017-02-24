function [ret] = stoch(in, len, win)

sto(1:len) = 0;
for idx=win:len
    hi=max(in(idx-win+1:idx));
    lo=min(in(idx-win+1:idx));
    sto(idx) = (in(idx)-lo)/(hi-lo);
    %if(sto(idx)>1) sto(idx) = 1; end
    %if(sto(idx)<0) sto(idx) = 0; end
end
sto(1:win-1)=sto(win);
ret = sto;
