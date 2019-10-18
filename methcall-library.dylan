module: dylan-user

define library methcall
  use common-dylan;
  use io;
end library;

define module methcall
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;
