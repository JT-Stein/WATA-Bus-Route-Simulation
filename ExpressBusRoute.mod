BEGIN;

! A(1) = onboard passengers
! A(2) = route start time
! A(3) = passenger-hours
! A(4) = last update time
! A(5) = boarding passengers
! A(6) = departing passengers
! A(7) = boarding time in seconds
! A(8) = departing time in seconds
! A(9) = traffic probability
! A(10) = break time in minutes
! A(11) = traffic delay in minutes
! A(12) = total boarding passengers

CREATE: 4,1: NEXT(StartRoute);

StartRoute ASSIGN: A(1)=0:
    A(2)=TNOW:
    A(3)=0:
    A(4)=TNOW:
    A(7)=5:
    A(8)=5:
    A(9)=0.08:
    A(10)=5:
    A(11)=2:
    A(12)=0;

! STOP 01: S Henry St at W&M Gradplex

Stop01 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(0.5+LOGN(1.82,1.74))):
    A(6)=MIN(A(1),MAX(0,(0.5+WEIB(1.34,1.85))));
    TALLY: Board_Gradplex, A(5);
    TALLY: Off_Gradplex, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6):
        A(12)=A(12)+A(5);
    DELAY: 0.000000/60+(A(7)*A(5)+A(8)*A(6))/3600;

! SEGMENT 01 to 02

Segment01 DELAY: 4.091166/60;

BRANCH, 1:
    IF, UNIF(0,1) .LT. A(9), Traffic01:
    ELSE, Stop02;

Traffic01 DELAY: A(11)/60: NEXT(Stop02);

! STOP 02: Jamestown Rd at Lemon Hall

Stop02 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(-0.5+ERLA(0.396,3))):
    A(6)=MIN(A(1),MAX(0,(-0.5+GAMM(0.577,2.27))));
    TALLY: Board_LemonHall, A(5);
    TALLY: Off_LemonHall, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6):
        A(12)=A(12)+A(5);
    DELAY: 0.194557/60+(A(7)*A(5)+A(8)*A(6))/3600;

! SEGMENT 02 to 03

Segment02 DELAY: 1.547280/60;

BRANCH, 1:
    IF, UNIF(0,1) .LT. A(9), Traffic02:
    ELSE, Stop03;

Traffic02 DELAY: A(11)/60: NEXT(Stop03);

! STOP 03: Ukrop Way at Jones Hall

Stop03 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(-0.5+GAMM(0.822,2.87))):
    A(6)=MIN(A(1),MAX(0,(POIS(0.581))));
    TALLY: Board_JonesHall, A(5);
    TALLY: Off_JonesHall, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6):
        A(12)=A(12)+A(5);
    DELAY: 0.198661/60+(A(7)*A(5)+A(8)*A(6))/3600;

! SEGMENT 03 to 04

Segment03 DELAY: 0.713745/60;

BRANCH, 1:
    IF, UNIF(0,1) .LT. A(9), Traffic03:
    ELSE, Stop04;

Traffic03 DELAY: A(11)/60: NEXT(Stop04);

! STOP 04: Ukrop Way at Small Hall

Stop04 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(-0.5+ERLA(0.641,2))):
    A(6)=MIN(A(1),MAX(0,(POIS(0.0323))));
    TALLY: Board_SmallHall, A(5);
    TALLY: Off_SmallHall, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6):
        A(12)=A(12)+A(5);
    DELAY: 0.301516/60+(A(7)*A(5)+A(8)*A(6))/3600;

! SEGMENT 04 to 05

Segment04 DELAY: 0.713745/60;

BRANCH, 1:
    IF, UNIF(0,1) .LT. A(9), Traffic04:
    ELSE, Stop05;

Traffic04 DELAY: A(11)/60: NEXT(Stop05);

! STOP 05: Ukrop Way at Yates Lot
! Final outbound stop and turnaround point.

Stop05 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(TRIA(-0.5,-0.0625,1.5))):
    A(6)=MIN(A(1),MAX(0,(-0.5+GAMM(0.276,3.17))));
    TALLY: Board_YatesLot, A(5);
    TALLY: Off_YatesLot, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6):
        A(12)=A(12)+A(5);
    DELAY: 0.302889/60+(A(7)*A(5)+A(8)*A(6))/3600;

! RETURN JOURNEY
! No intermediate passenger service.

! Yates Lot to Small Hall

Return04 DELAY: 0.713745/60;

BRANCH, 1:
    IF, UNIF(0,1) .LT. A(9), RetTraffic04:
    ELSE, Return03;

RetTraffic04 DELAY: A(11)/60: NEXT(Return03);

! Small Hall to Jones Hall

Return03 DELAY: 0.713745/60;

BRANCH, 1:
    IF, UNIF(0,1) .LT. A(9), RetTraffic03:
    ELSE, Return02;

RetTraffic03 DELAY: A(11)/60: NEXT(Return02);

! Jones Hall to Lemon Hall

Return02 DELAY: 1.547280/60;

BRANCH, 1:
    IF, UNIF(0,1) .LT. A(9), RetTraffic02:
    ELSE, Return01;

RetTraffic02 DELAY: A(11)/60: NEXT(Return01);

! Lemon Hall to Gradplex

Return01 DELAY: 4.091166/60;

BRANCH, 1:
    IF, UNIF(0,1) .LT. A(9), RetTraffic01:
    ELSE, ReturnGradplex;

RetTraffic01 DELAY: A(11)/60: NEXT(ReturnGradplex);

! RETURN TO GRADPLEX
! All remaining passengers depart.

ReturnGradplex ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=0:
    A(6)=A(1);
    TALLY: Off_GradplexReturn, A(6);
    ASSIGN: A(1)=0;
    DELAY: A(8)*A(6)/3600;

! ROUTE COMPLETION

FinishRoute ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4));
    TALLY: Occupancy, A(3)/(TNOW-A(2));
    TALLY: RouteTime, (TNOW-A(2))*60;
    TALLY: TotalBoardings, A(12);

! DRIVER BREAK

    DELAY: A(10)/60;
    TALLY: CycleTime, (TNOW-A(2))*60;
    DISPOSE;

END;
