module: dylan-user

define library sieve
  use common-dylan;
  use io;
end library;

define module sieve
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
