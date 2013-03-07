module: fibo

define library fibo
  use common-dylan;
  use io;
end library;

define module fibo
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;

define function fibo(M :: <integer>)
 => result :: <integer>;
  case 
    M < 1     => 0;
    M = 1     => 1;
    otherwise => fibo (M - 2) + fibo (M - 1);
  end case;
end function fibo;

begin
  let arg = application-arguments()[0].string-to-integer;
  format-out("%d\n", fibo(arg));
end;

