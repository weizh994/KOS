clearScreen.//清除屏幕
print"倒计时".
from {local N is 10.} until n=0 step{set n to n-1.}do
{
    print"..."+N.
    wait 1.
}
print"Lift Off".
//倒计时10秒
lock throttle to 1.0.//节流阀最大
stage.//1级点火
wait until ship:altitude > 70000.
