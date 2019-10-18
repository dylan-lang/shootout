module: dylan-user

define library fibo
  use common-dylan;
  use io;
end library;

define module fibo
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
