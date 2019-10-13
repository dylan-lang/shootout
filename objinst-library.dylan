module: dylan-user

define library objinst
  use common-dylan;
  use io;
end library;

define module objinst
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
