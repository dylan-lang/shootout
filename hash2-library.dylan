module: dylan-user

define library hash2
  use common-dylan;
  use io;
end library;

define module hash2
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
