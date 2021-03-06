function HP_lose = heating (fc,V1,sf)
  % AD = 50;
  % HP_max = 750;
  % Q1 = 1500;
  % cooling_rate = 500;
  % V0 = 30;
  global AD;
  global HP_max;
  global cooling_rate;
  global V0;
  global Q0;
  Q1 = 0;
  cool_times = 1*fc;
  HP_lose = 0;
  HP_lose_c = 0;
  HP_lose_g = 0;
  bullet_num = ceil(sf * 1.0 / cool_times); % bullet number per cooling period
  for i  = 1 : cool_times
    % Gaining Heat
    for j = 1 : bullet_num
      [Q1 HP_lose_g1] = gain_heat(Q1,Q0,V0,V1,AD,HP_max);
      HP_lose_g = HP_lose_g + HP_lose_g1 * bullet_num;
    end
    % Cooling
    [Q1 HP_lose_c1] = lose_heat(Q1,Q0,cooling_rate,HP_max);
    HP_lose_c = HP_lose_c + HP_lose_c1;
  end

  HP_lose = HP_lose_c + HP_lose_g;
  if (HP_lose > HP_max)
    HP_lose = HP_max;
  else if (HP_lose < 0)
    HP_lose = 0;
  end

  end
end


function [Q1 HP_lose] = gain_heat(Q1,Q0,V0,V1,AD,HP_max)
    HP_lose = 0;
    % for 17mm bullet
    if (AD == 50)
      Q1 = Q1 + V1^2;
      % Over heating penlaty :
      if (Q1 > 1.5 * Q0)
        HP_lose = HP_lose + HP_max * (Q1 - 1.5 * Q0) / 2000;
        Q1 = 1.5 * Q0;
      end

      % Over shooting_speed penlaty :
      if (V1 - V0 >= 10)
        HP_lose = HP_lose + HP_max;
      elseif (V1 - V0 > 5)
        HP_lose = HP_lose + 0.5 * HP_max;
      elseif (V1 - V0 > 0)
        HP_lose = HP_lose + 0.1 * HP_max;
      end

    % for 45mm bullet
    elseif (AD == 500)
      Q1 = Q1 + 1600;
      % penalty on heat
      if (Q1 > 1.5 * Q0)
        HP_lose = HP_lose + HP_max * (Q1 - 1.5 * Q0) / 2000;
        Q1 = 1.5 * Q0;
      % Over shooting_speed penlaty :
      elseif (V1 > 1.2 * V0)
        HP_lose = 0.5 * HP_max;
      elseif (V1 > V0)
        HP_lose = 0.2 * HP_max;
      end
    end
end

function [Q1 HP_lose] = lose_heat(Q1,Q0,cooling_rate,HP_max)
  HP_lose = 0;
  if (Q0 < Q1)
    HP_lose = HP_max * (Q1 - Q0)/2000;
  end
  Q1 = Q1 - cooling_rate * 0.1;
end
