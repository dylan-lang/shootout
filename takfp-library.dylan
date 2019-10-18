module: dylan-user

define library takfp
  use common-dylan;
  use io;
end library;

define module takfp
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
