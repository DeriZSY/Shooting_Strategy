function feasibleState=fesibJudge(particle,VarMinF,VarMaxF,nVar)
% judge if it's in position
% fesiableState = true;
%     for i = 1:nVar
% %         disp(particle.Position(i));
% %         disp(VarMinF(i));
% %         disp( VarMaxF(i));
% %         disp(fesiableState);
% %         disp('roundStrat');
%     	if particle.Position(i) <= VarMinF(i) || particle.Position(i) >= VarMaxF(i)
%     		fesiableState = false;
%         end
% %         disp(fesiableState);
% %         disp('roundend ');
%     end
  global AD;
  global HP_max;
  global cooling_rate;
  global V0;
  global Q0;
  fc = 10; % refresh frequency
  x  = particle.Position;
  V1 = x(1);% bullet velocity
  sf = x(2);% shooting frequency
  feasibleState = true;
  for i = 1 : nVar
    if (x(i) > VarMaxF(i) || x(i) < VarMinF(i))
      feasibleState = feasibleState & false;
    end
  end
  % HP_lose = heating(fc,V1,sf);
  HP_lose = particle.HP_L;
  if ( HP_lose > 0 )
    feasibleState = false;
  else
    feasibleState = true & feasibleState;
  end

end
