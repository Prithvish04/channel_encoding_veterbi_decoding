
function [previousState,decodedBit]=prev_stage(currentState,distancePrevious)
    if(currentState==1)
        if(distancePrevious(1) <= distancePrevious(3))
            previousState=1;decodedBit=0;
        else
            previousState=3;decodedBit=0;
        end
    end
    
    if(currentState==2)
        if(distancePrevious(1) <= distancePrevious(3))
            previousState=1;decodedBit=1;
        else
            previousState=3;decodedBit=1;
        end
    end
    
    if(currentState==3)
        if(distancePrevious(2) <= distancePrevious(4))
            previousState=2;decodedBit=0;
        else
            previousState=4;decodedBit=0;
        end
    end
    
    if(currentState==4)
        if(distancePrevious(2)<= distancePrevious(4))
            previousState=2;decodedBit=1;
        else
            previousState=4;decodedBit=1;
        end
    end
    
end