clearScreen.
print"倒计时".
from {local N is 10.} until n=0 step{set n to n-1.}do
{
    print"..."+N.
    wait 1.
}
print"Lift Off".