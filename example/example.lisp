(cl:defpackage :mathfu.example
  (:use :cl)
  (:export #:run
           #:run-repeated))
(cl:in-package :mathfu.example)

;;;
;;; VEC
;;;
(defun make-vec4 (x y z w)
  (cffi:with-foreign-objects ((x-ptr :float)
                              (y-ptr :float)
                              (z-ptr :float)
                              (w-ptr :float))
    (setf (cffi:mem-ref x-ptr :float) (float x 0f0)
          (cffi:mem-ref y-ptr :float) (float y 0f0)
          (cffi:mem-ref z-ptr :float) (float z 0f0)
          (cffi:mem-ref w-ptr :float) (float w 0f0))
    (iffi:make-intricate-instance '%mathfu:mathfu-vector<float+4>
                                  '(:pointer :float) x-ptr
                                  '(:pointer :float) y-ptr
                                  '(:pointer :float) z-ptr
                                  '(:pointer :float) w-ptr)))


(defun vec4 (vec idx)
  (cffi:mem-ref (%mathfu:|MATHFU-OPERATOR()| '(:pointer %mathfu:mathfu-vector<float+4>) vec :int idx) :float))


(defun (setf vec4) (value vec idx)
  (setf (cffi:mem-ref (%mathfu:|MATHFU-OPERATOR()| '(:pointer %mathfu:mathfu-vector<float+4>) vec :int idx) :float) (float value 0f0)))


(declaim (inline vec4+))
(defun vec4+ (result-vec this-vec that-vec)
  (%mathfu:mathfu-operator+ '(:pointer %mathfu::mathfu-vector<float+4>) result-vec
                            '(:pointer %mathfu::mathfu-vector<float+4>) this-vec
                            '(:pointer %mathfu::mathfu-vector<float+4>) that-vec))

(defun format-vec4 (vec)
  (format nil "#<vec4 ~A ~A ~A ~A" (vec4 vec 0) (vec4 vec 1) (vec4 vec 2) (vec4 vec 3)))

;;;
;;; MAT
;;;
(defun make-mat4 (a0 a1 a2 a3
                  a4 a5 a6 a7
                  a8 a9 a10 a11
                  a12 a13 a14 a15)
  (iffi:make-intricate-instance '%mathfu:mathfu-matrix<float+4+4>
                                :float (float a0 0f0)
                                :float (float a1 0f0)
                                :float (float a2 0f0)
                                :float (float a3 0f0)
                                :float (float a4 0f0)
                                :float (float a5 0f0)
                                :float (float a6 0f0)
                                :float (float a7 0f0)
                                :float (float a8 0f0)
                                :float (float a9 0f0)
                                :float (float a10 0f0)
                                :float (float a11 0f0)
                                :float (float a12 0f0)
                                :float (float a13 0f0)
                                :float (float a14 0f0)
                                :float (float a15 0f0)))


(defun make-mat4-identity ()
  (make-mat4 1 0 0 0
             0 1 0 0
             0 0 1 0
             0 0 0 1))


(defun mat4 (mat row col)
  (cffi:mem-ref (%mathfu:|MATHFU-OPERATOR()|
                         '(:pointer %mathfu:mathfu-matrix<float+4+4>) mat
                         :int row
                         :int col)
                :float))


(defun (setf mat4) (value mat row col)
  (setf (cffi:mem-ref (%mathfu:|MATHFU-OPERATOR()|
                               '(:pointer %mathfu:mathfu-matrix<float+4+4>) mat
                               :int row
                               :int col)
                      :float)
        (float value 0f0)))

(declaim (inline mat4*))
(defun mat4* (result this-mat that-mat)
  (%mathfu:mathfu-operator*
   '(:pointer %mathfu::mathfu-matrix<float+4+4>) result
   '(:pointer %mathfu::mathfu-matrix<float+4+4>) this-mat
   '(:pointer %mathfu::mathfu-matrix<float+4+4>) that-mat))


(declaim (inline mat4+))
(defun mat4+ (result this-mat that-mat)
  (%mathfu:mathfu-operator+
   '(:pointer %mathfu::mathfu-matrix<float+4+4>) result
   '(:pointer %mathfu::mathfu-matrix<float+4+4>) this-mat
   '(:pointer %mathfu::mathfu-matrix<float+4+4>) that-mat))


(defun format-mat4 (mat)
  (with-output-to-string (out)
    (format out "#<mat4")
    (loop for col from 0 below 4
          do (loop for row from 0 below 4
                   do (format out " ~A" (mat4 mat row col))))
    (format out ">")))

;;;
;;; DEMO
;;;
(defun run ()
  (let ((vec0 (make-vec4 1 2 3 4))
        (vec1 (make-vec4 4 3 2 1))
        (result (make-vec4 0 0 0 0)))
    (vec4+ result vec0 vec1)
    (print (format-vec4 result)))
  (let ((mat0 (make-mat4 1 2 3 4
                         1 2 3 4
                         1 2 3 4
                         1 2 3 4))
        (mat1 (make-mat4-identity))
        (result (make-mat4 0 0 0 0
                           0 0 0 0
                           0 0 0 0
                           0 0 0 0)))
    (mat4* result mat0 mat1)
    (print (format-mat4 result))))


(defun run-repeated (&optional (repeats 1000))
  (declare (optimize (speed 3) (safety 1) (debug 0)))
  (let ((mat0 (make-mat4 1 2 3 4
                         1 2 3 4
                         1 2 3 4
                         1 2 3 4))
        (mat1 (make-mat4-identity))
        (result (make-mat4 0 0 0 0
                           0 0 0 0
                           0 0 0 0
                           0 0 0 0)))
    (loop repeat repeats
          do (mat4+ result mat0 mat1))))


(defun run-repeated-vec4 (&optional (repeats 1000))
  (declare (optimize (speed 3) (safety 1) (debug 0)))
  (let ((vec0 (make-vec4 1 2 3 4))
        (vec1 (make-vec4 4 3 2 1))
        (result (make-vec4 0 0 0 0)))
    (loop repeat repeats
          do (vec4+ result vec0 vec1))))
