module: dylan-user

define library except
  use common-dylan;
  use io;
end library;

define module except
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
