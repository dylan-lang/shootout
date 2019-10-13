module: dylan-user

define library hash
  use common-dylan;
  use io;
end library;

define module hash
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
