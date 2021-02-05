//声明朝向 head
//function head{
//    set v to Ship:airspeed.//设v为火箭的地面速度
//    set p to 90-sqrt(v)*1.6.//火箭的俯仰角p和v相关
//    return heading(90,p).
//}
global S is 1.//定义火箭级数

// 判断是否需要分级的函数
function shouldStage{
    list engines in _en.
    local _m is 0. // 有动力的引擎数量
    for _e in _en{
        if _e:ignition and not _e:flameout {
            set _m to _m+1.
        }
    }
    return _m = 0 and _en:length>0.
}

// 执行分级操作的函数
function stageNext{
    until not shouldStage() {
        print S+"级点火".
        stage.
        set S to S+1.
        wait until stage:ready.
    }
}

//发射前准备
lock steering to heading(0,90).
lock throttle to 1.0.//节流阀最大
//准备发射
clearScreen.//清除屏幕
print"倒计时".
from {local N is 10.} until n=0 step{set n to n-1.}do
{
    print"..."+N.
    wait 1.
}
print"Lift Off".
//倒计时10秒
wait 0.5.
//如果最大推力=0，就点火下一级

stageing().

wait until ship:altitude > 500.
lock steering to heading(0,90) + R(0,-30,0).

wait until ship:maxthrust = 0.
stageing().



wait until ship:altitude >70000.
print "发射完成".
sas on.
