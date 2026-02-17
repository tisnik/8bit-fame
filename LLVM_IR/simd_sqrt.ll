; ModuleID = 'simd_sqrt.c'
source_filename = "simd_sqrt.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: nofree nounwind optsize memory(write) uwtable
define dso_local <4 x float> @vector_sqrt_f32x4(<4 x float> noundef %0) local_unnamed_addr #0 {
  br label %2

2:                                                ; preds = %1, %2
  %3 = phi i32 [ 0, %1 ], [ %8, %2 ]
  %4 = phi <4 x float> [ undef, %1 ], [ %7, %2 ]
  %5 = extractelement <4 x float> %0, i32 %3
  %6 = tail call float @sqrtf(float noundef %5) #3, !tbaa !3
  %7 = insertelement <4 x float> %4, float %6, i32 %3
  %8 = add nuw nsw i32 %3, 1
  %9 = icmp eq i32 %8, 4
  br i1 %9, label %10, label %2, !llvm.loop !7

10:                                               ; preds = %2
  ret <4 x float> %7
}

; Function Attrs: mustprogress nofree nounwind optsize willreturn memory(write)
declare dso_local float @sqrtf(float noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nounwind optsize willreturn memory(write) uwtable
define dso_local <2 x double> @vector_sqrt_f64x2(<2 x double> noundef %0) local_unnamed_addr #2 {
  %2 = extractelement <2 x double> %0, i64 0
  %3 = tail call double @sqrt(double noundef %2) #3, !tbaa !3
  %4 = insertelement <2 x double> poison, double %3, i64 0
  %5 = extractelement <2 x double> %0, i64 1
  %6 = tail call double @sqrt(double noundef %5) #3, !tbaa !3
  %7 = insertelement <2 x double> %4, double %6, i64 1
  ret <2 x double> %7
}

; Function Attrs: mustprogress nofree nounwind optsize willreturn memory(write)
declare dso_local double @sqrt(double noundef) local_unnamed_addr #1

attributes #0 = { nofree nounwind optsize memory(write) uwtable "min-legal-vector-width"="128" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree nounwind optsize willreturn memory(write) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nofree nounwind optsize willreturn memory(write) uwtable "min-legal-vector-width"="128" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind optsize }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
