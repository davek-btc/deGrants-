;; title: proposal-trait
;; version: 0.1
;; summary: HiroHacks #2 Decentralized Grants Program
;; description: Discover decentralized funding with our guide on creating a DeGrant Program
;;              for token holders. Learn to establish a community-driven grant system, empowering token 
;;              holders to support innovative projects and foster collective progress.



 ;;proposal-trait.clar
(define-trait proposal-trait
  (
    (execute (principal) (response bool uint))
  )
)

