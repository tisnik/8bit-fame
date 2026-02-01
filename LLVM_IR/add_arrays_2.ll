; ModuleID = 'add_arrays_2.c'
source_filename = "add_arrays_2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind optsize memory(argmem: readwrite) uwtable
define dso_local void @add_arrays(ptr noalias nocapture noundef %0, ptr noalias nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = load <16 x i8>, ptr %1, align 1, !tbaa !3
  %4 = load <16 x i8>, ptr %0, align 1, !tbaa !3
  %5 = add <16 x i8> %4, %3
  store <16 x i8> %5, ptr %0, align 1, !tbaa !3
  ret void
}

attributes #0 = { nofree norecurse nosync nounwind optsize memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
