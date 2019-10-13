module: dylan-user

define library pidigits
  use common-dylan;
  use io;
end library;

define module pidigits
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
