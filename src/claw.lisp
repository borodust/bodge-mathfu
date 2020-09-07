(cl:defpackage :mathfu
  (:use :cl)
  (:export))
(cl:defpackage :%mathfu
  (:use))


(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun mathfu::ignore-uninstantiable ()
    (claw-utils::ignore-functions
      ;; vec2
      (claw-utils::in-class "mathfu::Vector<int,2>"
                            (:ctor "int" "int" "int" "int")
                            (:ctor "int" "int" "int")
                            (:ctor "mathfu::Vector<int,3>" "int")
                            ("xyz")
                            ("CrossProduct" "mathfu::Vector<int,3>" "mathfu::Vector<int,3>"))
      (claw-utils::in-class "mathfu::Vector<float,2>"
                            (:ctor "float" "float" "float" "float")
                            (:ctor "float" "float" "float")
                            (:ctor "mathfu::Vector<float,3>" "float")
                            ("xyz")
                            ("CrossProduct" "mathfu::Vector<float,3>" "mathfu::Vector<float,3>"))
      (claw-utils::in-class "mathfu::Vector<double,2>"
                            (:ctor "double" "double" "double" "double")
                            (:ctor "double" "double" "double")
                            (:ctor "mathfu::Vector<double,3>" "double")
                            ("xyz")
                            ("CrossProduct" "mathfu::Vector<double,3>" "mathfu::Vector<double,3>"))
      ;; vec3
      (claw-utils::in-class "mathfu::Vector<int,3>"
                            (:ctor "int" "int" "int" "int")
                            (:ctor "int" "int"))
      (claw-utils::in-class "mathfu::Vector<float,3>"
                            (:ctor "float" "float" "float" "float")
                            (:ctor "float" "float"))
      (claw-utils::in-class "mathfu::Vector<double,3>"
                            (:ctor "double" "double" "double" "double")
                            (:ctor "double" "double"))
      ;; vec4
      (claw-utils::in-class "mathfu::Vector<int,4>"
                            (:ctor "int" "int" "int")
                            (:ctor "int" "int"))

      (claw-utils::in-class "mathfu::Vector<float,4>"
                            (:ctor "float" "float" "float")
                            (:ctor "float" "float"))
      (claw-utils::in-class "mathfu::Vector<double,4>"
                            (:ctor "double" "double" "double")
                            (:ctor "double" "double"))
      ;; mat22
      (claw-utils::in-class "mathfu::Matrix<float,2,2>"
                            (:ctor "float" "float" "float" "float"
                                   "float" "float" "float" "float"
                                   "float" "float" "float" "float"
                                   "float" "float" "float" "float")
                            (:ctor "float" "float" "float" "float"
                                   "float" "float" "float" "float"
                                   "float" "float" "float" "float")
                            (:ctor "float" "float" "float"
                                   "float" "float" "float"
                                   "float" "float" "float")
                            (:ctor "mathfu::Vector<float,4>"
                                   "mathfu::Vector<float,4>"
                                   "mathfu::Vector<float,4>"
                                   "mathfu::Vector<float,4>")
                            ("TranslationVector3D")
                            ("ScaleVector3D")
                            ("HadamardProduct" :any))
      ;; mat33
      (claw-utils::in-class "mathfu::Matrix<float,3,3>"
                            (:ctor "float" "float" "float" "float"
                                   "float" "float" "float" "float"
                                   "float" "float" "float" "float"
                                   "float" "float" "float" "float")
                            (:ctor "float" "float" "float" "float"
                                   "float" "float" "float" "float"
                                   "float" "float" "float" "float")
                            (:ctor  "float" "float"
                                    "float" "float")
                            (:ctor "mathfu::Vector<float,4>"
                                   "mathfu::Vector<float,4>"
                                   "mathfu::Vector<float,4>"
                                   "mathfu::Vector<float,4>")
                            ("TranslationVector3D")
                            ("ScaleVector3D")
                            ("HadamardProduct" :any))
      ;; mat43
      (claw-utils::in-class "mathfu::Matrix<float,4,3>"
                            (:ctor "float" "float" "float" "float"
                                   "float" "float" "float" "float"
                                   "float" "float" "float" "float"
                                   "float" "float" "float" "float")
                            (:ctor  "float" "float" "float" "float"
                                    "float" "float" "float" "float"
                                    "float" "float" "float" "float")
                            (:ctor "float" "float" "float"
                                   "float" "float" "float"
                                   "float" "float" "float")
                            (:ctor "float" "float"
                                   "float" "float")
                            (:ctor "mathfu::Vector<float,4>"
                                   "mathfu::Vector<float,4>"
                                   "mathfu::Vector<float,4>"
                                   "mathfu::Vector<float,4>")
                            ("operator*" :any)
                            ("operator*=" :any)
                            ("TranslationVector3D")
                            ("ScaleVector3D")
                            ("InverseWithDeterminantCheck" :any)
                            ("Inverse" :any)
                            ("HadamardProduct" :any))
      ;; mat44
      (claw-utils::in-class "mathfu::Matrix<float,4,4>"
                            (:ctor "float" "float" "float" "float"
                                   "float" "float" "float" "float"
                                   "float" "float" "float" "float")
                            (:ctor "float" "float" "float"
                                   "float" "float" "float"
                                   "float" "float" "float")
                            (:ctor "float" "float"
                                   "float" "float")
                            ("HadamardProduct" :any)))))

(claw.wrapper:defwrapper (mathfu::claw-mathfu
                          (:headers "mathfu/vector.h"
                                    "mathfu/matrix.h"
                                    "mathfu/quaternion.h"
                                    "mathfu/glsl_mappings.h"
                                    "mathfu/constants.h"
                                    "mathfu/rect.h")
                          (:includes :mathfu-includes :mathfu-vectorial-includes)
                          (:targets :local)
                          (:persistent nil)
                          (:language :c++)
                          (:include-definitions "mathfu::.*"))
  :in-package :%mathfu
  :trim-enum-prefix t
  :recognize-bitfields t
  :recognize-strings t
  :ignore-entities (mathfu::ignore-uninstantiable)
  :with-adapter :static
  :override-types ((:string claw-utils:claw-string)
                   (:pointer claw-utils:claw-pointer)))
