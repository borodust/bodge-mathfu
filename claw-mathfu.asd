(asdf:defsystem :claw-mathfu
  :description "Wrapper over Google's MathFu"
  :version "1.0.0"
  :author "Pavel Korolev"
  :mailto "dev@borodust.org"
  :license "MIT"
  :depends-on (:alexandria :cffi :claw :claw-utils)
  :serial t
  :pathname "src/"
  :components ((:file "claw")
               (:module :bindings)
               (:module :mathfu-includes :pathname "lib/mathfu/include/")
               (:module :mathfu-vectorial-includes
                :pathname "lib/mathfu/dependencies/vectorial/include/")))


(asdf:defsystem :claw-mathfu/example
  :description ""
  :version "1.0.0"
  :author "Pavel Korolev"
  :mailto "dev@borodust.org"
  :license "MIT"
  :depends-on (:claw-mathfu)
  :serial t
  :pathname "example/"
  :components ((:file "example")))
