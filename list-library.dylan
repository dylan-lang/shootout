module: dylan-user

define library list
  use common-dylan;
  use io;
end library;

define module list
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
