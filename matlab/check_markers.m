
val = 110; % snapshot at 110th record

leftX = [ mk.Z24(val); mk.Z23(val) ];
leftY = [ mk.X24(val); mk.X23(val) ];

rightX = [ mk.Z21(val); mk.Z20(val) ]; 
rightY = [ mk.X21(val); mk.X20(val) ]; 

left = patch(  leftX, leftY, [ 0.192, 0.192, 0.192] );
hold on
right = patch(  rightX, rightY, [ 0.192, 0.192, 0.192] );