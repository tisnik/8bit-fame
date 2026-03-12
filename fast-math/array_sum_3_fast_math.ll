; ModuleID = 'array_sum_3.c'
source_filename = "array_sum_3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

@array = dso_local local_unnamed_addr global [100000 x float] zeroinitializer, align 16
@.str = private unnamed_addr constant [11 x i8] c"Sum: %.4f\0A\00", align 1
@.str.1 = private unnamed_addr constant [15 x i8] c"Time: %.4f ms\0A\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(read, argmem: none, inaccessiblemem: none) uwtable
define dso_local nofpclass(nan inf) float @sum_array() local_unnamed_addr #0 {
  br label %1

1:                                                ; preds = %1, %0
  %2 = phi i64 [ 0, %0 ], [ %39, %1 ]
  %3 = phi <4 x float> [ zeroinitializer, %0 ], [ %37, %1 ]
  %4 = phi <4 x float> [ zeroinitializer, %0 ], [ %38, %1 ]
  %5 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %2
  %6 = getelementptr inbounds nuw i8, ptr %5, i64 16
  %7 = load <4 x float>, ptr %5, align 16, !tbaa !3
  %8 = load <4 x float>, ptr %6, align 16, !tbaa !3
  %9 = fadd fast <4 x float> %7, %3
  %10 = fadd fast <4 x float> %8, %4
  %11 = add nuw nsw i64 %2, 8
  %12 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %11
  %13 = getelementptr inbounds nuw i8, ptr %12, i64 16
  %14 = load <4 x float>, ptr %12, align 16, !tbaa !3
  %15 = load <4 x float>, ptr %13, align 16, !tbaa !3
  %16 = fadd fast <4 x float> %14, %9
  %17 = fadd fast <4 x float> %15, %10
  %18 = add nuw nsw i64 %2, 16
  %19 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %18
  %20 = getelementptr inbounds nuw i8, ptr %19, i64 16
  %21 = load <4 x float>, ptr %19, align 16, !tbaa !3
  %22 = load <4 x float>, ptr %20, align 16, !tbaa !3
  %23 = fadd fast <4 x float> %21, %16
  %24 = fadd fast <4 x float> %22, %17
  %25 = add nuw nsw i64 %2, 24
  %26 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %25
  %27 = getelementptr inbounds nuw i8, ptr %26, i64 16
  %28 = load <4 x float>, ptr %26, align 16, !tbaa !3
  %29 = load <4 x float>, ptr %27, align 16, !tbaa !3
  %30 = fadd fast <4 x float> %28, %23
  %31 = fadd fast <4 x float> %29, %24
  %32 = add nuw nsw i64 %2, 32
  %33 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %32
  %34 = getelementptr inbounds nuw i8, ptr %33, i64 16
  %35 = load <4 x float>, ptr %33, align 16, !tbaa !3
  %36 = load <4 x float>, ptr %34, align 16, !tbaa !3
  %37 = fadd fast <4 x float> %35, %30
  %38 = fadd fast <4 x float> %36, %31
  %39 = add nuw nsw i64 %2, 40
  %40 = icmp eq i64 %39, 100000
  br i1 %40, label %41, label %1, !llvm.loop !7

41:                                               ; preds = %1
  %42 = fadd fast <4 x float> %38, %37
  %43 = tail call fast float @llvm.vector.reduce.fadd.v4f32(float 0.000000e+00, <4 x float> %42)
  ret float %43
}

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #1 {
  br label %1

1:                                                ; preds = %1, %0
  %2 = phi i64 [ 0, %0 ], [ %17, %1 ]
  %3 = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, %0 ], [ %18, %1 ]
  %4 = add <4 x i32> %3, splat (i32 4)
  %5 = and <4 x i32> %3, splat (i32 1)
  %6 = and <4 x i32> %3, splat (i32 1)
  %7 = icmp eq <4 x i32> %5, zeroinitializer
  %8 = icmp eq <4 x i32> %6, zeroinitializer
  %9 = sub nsw <4 x i32> zeroinitializer, %3
  %10 = sub <4 x i32> splat (i32 -4), %3
  %11 = select <4 x i1> %7, <4 x i32> %9, <4 x i32> %3
  %12 = select <4 x i1> %8, <4 x i32> %10, <4 x i32> %4
  %13 = sitofp <4 x i32> %11 to <4 x float>
  %14 = sitofp <4 x i32> %12 to <4 x float>
  %15 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %2
  %16 = getelementptr inbounds nuw i8, ptr %15, i64 16
  store <4 x float> %13, ptr %15, align 16, !tbaa !3
  store <4 x float> %14, ptr %16, align 16, !tbaa !3
  %17 = add nuw i64 %2, 8
  %18 = add <4 x i32> %3, splat (i32 8)
  %19 = icmp eq i64 %17, 100000
  br i1 %19, label %20, label %1, !llvm.loop !11

20:                                               ; preds = %1
  %21 = tail call i64 @clock() #5
  br label %22

22:                                               ; preds = %22, %20
  %23 = phi i64 [ 0, %20 ], [ %60, %22 ]
  %24 = phi <4 x float> [ zeroinitializer, %20 ], [ %58, %22 ]
  %25 = phi <4 x float> [ zeroinitializer, %20 ], [ %59, %22 ]
  %26 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %23
  %27 = getelementptr inbounds nuw i8, ptr %26, i64 16
  %28 = load <4 x float>, ptr %26, align 16, !tbaa !3
  %29 = load <4 x float>, ptr %27, align 16, !tbaa !3
  %30 = fadd fast <4 x float> %28, %24
  %31 = fadd fast <4 x float> %29, %25
  %32 = add nuw nsw i64 %23, 8
  %33 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %32
  %34 = getelementptr inbounds nuw i8, ptr %33, i64 16
  %35 = load <4 x float>, ptr %33, align 16, !tbaa !3
  %36 = load <4 x float>, ptr %34, align 16, !tbaa !3
  %37 = fadd fast <4 x float> %35, %30
  %38 = fadd fast <4 x float> %36, %31
  %39 = add nuw nsw i64 %23, 16
  %40 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %39
  %41 = getelementptr inbounds nuw i8, ptr %40, i64 16
  %42 = load <4 x float>, ptr %40, align 16, !tbaa !3
  %43 = load <4 x float>, ptr %41, align 16, !tbaa !3
  %44 = fadd fast <4 x float> %42, %37
  %45 = fadd fast <4 x float> %43, %38
  %46 = add nuw nsw i64 %23, 24
  %47 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %46
  %48 = getelementptr inbounds nuw i8, ptr %47, i64 16
  %49 = load <4 x float>, ptr %47, align 16, !tbaa !3
  %50 = load <4 x float>, ptr %48, align 16, !tbaa !3
  %51 = fadd fast <4 x float> %49, %44
  %52 = fadd fast <4 x float> %50, %45
  %53 = add nuw nsw i64 %23, 32
  %54 = getelementptr inbounds nuw [100000 x float], ptr @array, i64 0, i64 %53
  %55 = getelementptr inbounds nuw i8, ptr %54, i64 16
  %56 = load <4 x float>, ptr %54, align 16, !tbaa !3
  %57 = load <4 x float>, ptr %55, align 16, !tbaa !3
  %58 = fadd fast <4 x float> %56, %51
  %59 = fadd fast <4 x float> %57, %52
  %60 = add nuw nsw i64 %23, 40
  %61 = icmp eq i64 %60, 100000
  br i1 %61, label %62, label %22, !llvm.loop !12

62:                                               ; preds = %22
  %63 = fadd fast <4 x float> %59, %58
  %64 = tail call fast float @llvm.vector.reduce.fadd.v4f32(float 0.000000e+00, <4 x float> %63)
  %65 = tail call i64 @clock() #5
  %66 = fpext fast float %64 to double
  %67 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef nofpclass(nan inf) %66)
  %68 = sub nsw i64 %65, %21
  %69 = sitofp i64 %68 to double
  %70 = fmul fast double %69, 1.000000e-03
  %71 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef nofpclass(nan inf) %70)
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local i64 @clock() local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fadd.v4f32(float, <4 x float>) #4

attributes #0 = { nofree norecurse nosync nounwind memory(read, argmem: none, inaccessiblemem: none) uwtable "approx-func-fp-math"="true" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #1 = { nounwind uwtable "approx-func-fp-math"="true" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #2 = { nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #3 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="true" }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"float", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = distinct !{!7, !8, !9, !10}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{!"llvm.loop.isvectorized", i32 1}
!10 = !{!"llvm.loop.unroll.runtime.disable"}
!11 = distinct !{!11, !8, !9, !10}
!12 = distinct !{!12, !8, !9, !10}
