module: nestedloop

begin
  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));
  let x :: <integer> = 0;

  for (a from 0 below arg)
    for (b from 0 below arg)
      for (c from 0 below arg)
        for (d from 0 below arg)
	  for (e from 0 below arg)
	    for (f from 0 below arg)
	      x := x + 1;
	    end for;
	  end for;
	end for;
      end for;
    end for;
  end for;
  
  format-out("%=\n", x);
end;

