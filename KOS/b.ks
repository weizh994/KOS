// 自动分级

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

wait until alt:radar>50.

when shouldStage() then {
    stageNext().
    wait 0.5.
    preserve.
}

wait until false.