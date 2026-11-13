
BEGIN;

! Route 8, chart order: 18 stop visits, 17 segments.
! Simulation time unit: hours.
! A(1) onboard, A(2) start, A(3) passenger-hours,
! A(4) last update, A(5) boarding, A(6) departing.
! Passenger draws are nonnegative but may be fractional.
! Stop dwell time: 5 seconds per boarding or departing passenger.
! Segments use fixed travel times; no random traffic events.

CREATE: 4,1000: NEXT(StartRoute);

StartRoute ASSIGN: A(1)=0:
    A(2)=TNOW:
    A(3)=0:
    A(4)=TNOW;

! STOP 01: S Henry St at W&M Gradplex
Stop01 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(0.5+LOGN(1.82,1.74))):
    A(6)=MIN(A(1),MAX(0,(0.5+WEIB(1.34,1.85))));
    TALLY: Board_Gradplex, A(5);
    TALLY: Off_Gradplex, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 01 to 02 (normal travel only)
Segment01 DELAY: 1.15/60;

! STOP 02: Jamestown Rd at Lemon Hall
Stop02 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(-0.5+ERLA(0.396,3))):
    A(6)=MIN(A(1),MAX(0,(-0.5+GAMM(0.577,2.27))));
    TALLY: Board_LemonHall, A(5);
    TALLY: Off_LemonHall, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 02 to 03 (normal travel only)
Segment02 DELAY: 1.15/60;

! STOP 03: Ukrop Way at Jones Hall
Stop03 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(-0.5+GAMM(0.822,2.87))):
    A(6)=MIN(A(1),MAX(0,(POIS(0.581))));
    TALLY: Board_JonesHall, A(5);
    TALLY: Off_JonesHall, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 03 to 04 (normal travel only)
Segment03 DELAY: 1.15/60;

! STOP 04: Ukrop Way at Small Hall
Stop04 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(-0.5+ERLA(0.641,2))):
    A(6)=MIN(A(1),MAX(0,(POIS(0.0323))));
    TALLY: Board_SmallHall, A(5);
    TALLY: Off_SmallHall, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 04 to 05 (normal travel only)
Segment04 DELAY: 1.15/60;

! STOP 05: Ukrop Way at Yates Lot
Stop05 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(TRIA(-0.5,-0.0625,1.5))):
    A(6)=MIN(A(1),MAX(0,(-0.5+GAMM(0.276,3.17))));
    TALLY: Board_YatesLot, A(5);
    TALLY: Off_YatesLot, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 05 to 06 (normal travel only)
Segment05 DELAY: 1.15/60;

! STOP 06: Compton Dr at Kaplan Arena (first visit)
Stop06 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(POIS(0.0323))):
    A(6)=MIN(A(1),MAX(0,(POIS(0.0606))));
    TALLY: Board_KaplanFirst, A(5);
    TALLY: Off_KaplanFirst, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 06 to 07 (normal travel only)
Segment06 DELAY: 1.15/60;

! STOP 07: Monticello Ave at Lot 1
Stop07 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(UNIF(0,1))):
    A(6)=MIN(A(1),MAX(0,(POIS(0.0323))));
    TALLY: Board_MonticelloLot1, A(5);
    TALLY: Off_MonticelloLot1, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 07 to 08 (normal travel only)
Segment07 DELAY: 1.15/60;

! STOP 08: Monticello Ave at School of Ed
Stop08 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(-0.5+WEIB(0.854,1.9))):
    A(6)=MIN(A(1),MAX(0,(-0.5+3*BETA(2.21,4.43))));
    TALLY: Board_SchoolEd, A(5);
    TALLY: Off_SchoolEd, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 08 to 09 (normal travel only)
Segment08 DELAY: 1.15/60;

! STOP 09: Mt Vernon Ave at Lot 4
Stop09 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(-0.5+LOGN(1.75,1.5))):
    A(6)=MIN(A(1),MAX(0,(-0.5+GAMM(0.803,1.98))));
    TALLY: Board_MtVernonLot4, A(5);
    TALLY: Off_MtVernonLot4, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 09 to 10 (normal travel only)
Segment09 DELAY: 1.15/60;

! STOP 10: Richmond Rd at Food Lion
Stop10 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(-0.5+LOGN(2.73,2.33))):
    A(6)=MIN(A(1),MAX(0,(TRIA(-0.5,0.438,2.5))));
    TALLY: Board_FoodLion, A(5);
    TALLY: Off_FoodLion, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 10 to 11 (normal travel only)
Segment10 DELAY: 1.15/60;

! STOP 11: Richmond Rd at Richmond Hall
Stop11 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(-0.5+WEIB(0.783,1.93))):
    A(6)=MIN(A(1),MAX(0,(UNIF(0,1))));
    TALLY: Board_RichmondHall, A(5);
    TALLY: Off_RichmondHall, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 11 to 12 (normal travel only)
Segment11 DELAY: 1.15/60;

! STOP 12: Compton Dr at Kaplan Arena (second visit)
Stop12 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(POIS(0.0312))):
    A(6)=MIN(A(1),MAX(0,(POIS(0.0625))));
    TALLY: Board_KaplanSecond, A(5);
    TALLY: Off_KaplanSecond, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 12 to 13 (normal travel only)
Segment12 DELAY: 1.15/60;

! STOP 13: Ukrop Way at Commons Dining
Stop13 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(-0.5+ERLA(0.271,3))):
    A(6)=MIN(A(1),MAX(0,(-0.5+WEIB(0.89,1.9))));
    TALLY: Board_CommonsDining, A(5);
    TALLY: Off_CommonsDining, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 13 to 14 (normal travel only)
Segment13 DELAY: 1.15/60;

! STOP 14: Ukrop Way at Wake Dr
Stop14 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(UNIF(0,1))):
    A(6)=MIN(A(1),MAX(0,(UNIF(0,1))));
    TALLY: Board_WakeDr, A(5);
    TALLY: Off_WakeDr, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 14 to 15 (normal travel only)
Segment14 DELAY: 1.15/60;

! STOP 15: Ukrop Way at W&M Parking Deck
Stop15 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(TRIA(-0.5,0.452,1.5))):
    A(6)=MIN(A(1),MAX(0,(-0.5+EXPO(2.97))));
    TALLY: Board_ParkingDeck, A(5);
    TALLY: Off_ParkingDeck, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 15 to 16 (normal travel only)
Segment15 DELAY: 1.15/60;

! STOP 16: Jamestown Rd at Indian Springs
Stop16 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(UNIF(0,1))):
    A(6)=MIN(A(1),MAX(0,(-0.5+WEIB(0.673,2.14))));
    TALLY: Board_IndianSprings, A(5);
    TALLY: Off_IndianSprings, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 16 to 17 (normal travel only)
Segment16 DELAY: 1.15/60;

! STOP 17: Jamestown Rd at Cary Street
Stop17 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(-0.5+WEIB(0.711,2.04))):
    A(6)=MIN(A(1),MAX(0,(-0.5+GAMM(0.276,3.17))));
    TALLY: Board_CaryStreet, A(5);
    TALLY: Off_CaryStreet, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! SEGMENT 17 to 18 (normal travel only)
Segment17 DELAY: 1.15/60;

! STOP 18: Jamestown Rd at Campus Center
Stop18 ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4)):
    A(4)=TNOW:
    A(5)=MAX(0,(TRIA(-0.5,-0.0625,1.5))):
    A(6)=MIN(A(1),MAX(0,(-0.5+ERLA(0.281,3))));
    TALLY: Board_CampusCenter, A(5);
    TALLY: Off_CampusCenter, A(6);
    ASSIGN: A(1)=A(1)+A(5)-A(6);
    DELAY: 5*(A(5)+A(6))/3600;

! Route completion and time-weighted occupancy
FinishRoute ASSIGN: A(3)=A(3)+A(1)*(TNOW-A(4));
    TALLY: Occupancy, A(3)/(TNOW-A(2));
    TALLY: RouteTime, (TNOW-A(2))*60;
    DISPOSE;

END;
