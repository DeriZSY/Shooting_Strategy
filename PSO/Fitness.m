function value = Fitness(x)
	V1 = x(1);
	sf = x(2);
	hit_rate = 1;
	% AD = 50;
	global AD;
	global fc;
	f1 = -hit(hit_rate,AD,sf);
	f2 = heating (fc,V1,sf);
	f = f1 + f2;
	value = [f1  f2]';
end

	%%%%% BfK Function %%%%%
	function value = BfK(X)
		x = X(1);
		y = X(2);
		f1 = 4*x^2 + 4*y^2;
		f2 = (x-5)^2 + (y-5)^2;
		value = [f1
		     f2];
	end

 %%%% hiting damage %%%%%%

 function damage = hit(hit_rate, AD,sf)
   damage = hit_rate * AD * sf;
 end