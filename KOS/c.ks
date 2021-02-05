// 重力转弯

set AP_HEIGHT to 100000.

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
        stage.
        wait until stage:ready.
    }
}

lock steering to heading(90,90,-90).
lock throttle to 1.

lock spd to velocity:surface.
when body:atm:altitudePressure(altitude)<0.01 then{
    lock spd to velocity:orbit.
}

// 计算俯仰角度
lock ang to 90 - vang(up:vector,spd).

wait until spd:mag>10.
// 激活自动分级任务
when shouldStage() then {
    stageNext().
    wait 0.5.
    preserve.
}

wait until spd:mag>50.
set toAng to 80.
lock steering to heading(90,toAng,-90). // 开始转弯
wait until abs(ang-toAng)<1.
wait until vang(facing:vector,spd)<0.05.
lock steering to heading(90,ang,-90). // 跟随速度的俯仰角度

set h to AP_HEIGHT * 0.95.
wait until apoapsis>h.
lock th to 1 - (apoapsis - h) / (AP_HEIGHT - h).
lock throttle to max(th,0.1).
wait until apoapsis >= AP_HEIGHT+500.

lock throttle to 0.
wait 1.
unlock throttle.
unlock steering.