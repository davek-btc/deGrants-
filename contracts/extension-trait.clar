;; title: extension-trait
;; version: 0.1
;; summary: HiroHacks #2 Decentralized Grants Program
;; description: Discover decentralized funding with our guide on creating a DeGrant Program
;;              for token holders. Learn to establish a community-driven grant system, empowering token 
;;              holders to support innovative projects and foster collective progress.


;; extension-trait.clar
(define-trait extension-trait
  (
    (callback (principal (buff 34)) (response bool uint))
  )
)