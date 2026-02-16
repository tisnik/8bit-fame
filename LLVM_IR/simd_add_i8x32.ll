; ModuleID = 'simd_add_i8x32.c'
source_filename = "simd_add_i8x32.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(argmem: read) uwtable
define dso_local <32 x i8> @add(ptr nocapture noundef readonly byval(<32 x i8>) align 32 %0, ptr nocapture noundef readonly byval(<32 x i8>) align 32 %1) local_unnamed_addr #0 {
  %3 = load <32 x i8>, ptr %0, align 32, !tbaa !3
  %4 = load <32 x i8>, ptr %1, align 32, !tbaa !3
  %5 = add <32 x i8> %4, %3
  ret <32 x i8> %5
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(argmem: read) uwtable "min-legal-vector-width"="256" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
