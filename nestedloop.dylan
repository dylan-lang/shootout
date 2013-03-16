module: nestedloop

define library nestedloop
  use common-dylan;
  use io;
end library;

define module nestedloop
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;

begin
  let arg = application-arguments()[0].string-to-integer;
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

