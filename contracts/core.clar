;; title: core
;; version: 0.1
;; summary: HiroHacks #2 Decentralized Grants Program
;; description: Discover decentralized funding with our guide on creating a DeGrant Program
;;              for token holders. Learn to establish a community-driven grant system, empowering token 
;;              holders to support innovative projects and foster collective progress.


;; Trait 
(use-trait proposal-trait .proposal-trait.proposal-trait)
(use-trait extension-trait .extension-trait.extension-trait)

;; Error Handling and State Management

(define-constant ERR_UNAUTHORIZED (err u1000))
(define-constant ERR_ALREADY_EXECUTED (err u1001))
(define-constant ERR_INVALID_EXTENSION (err u1002))

(define-data-var executive principal tx-sender)
(define-map executedProposals principal uint)
(define-map extensions principal bool)

;; Authorization Check

(define-private (is-self-or-extension)
  (ok (asserts! (or (is-eq tx-sender (as-contract tx-sender)) (is-extension contract-caller)) ERR_UNAUTHORIZED))
)

(define-read-only (is-extension (extension principal))
  (default-to false (map-get? extensions extension))
)

(define-read-only (executed-at (proposal <proposal-trait>))
  (map-get? executedProposals (contract-of proposal))
)

;; Extension Management

(define-public (set-extension (extension principal) (enabled bool))
  (begin
    (try! (is-self-or-extension))
    (print {event: "extension", extension: extension, enabled: enabled})
    (ok (map-set extensions extension enabled))
  )
)

;; Proposal Execution

(define-public (execute (proposal <proposal-trait>) (sender principal))
  (begin
    (try! (is-self-or-extension))
    (asserts! (map-insert executedProposals (contract-of proposal) block-height) ERR_ALREADY_EXECUTED)
    (print {event: "execute", proposal: proposal})
    (as-contract (contract-call? proposal execute sender))
  )
)

;; Bootstrap grants program

;; ######################################

;; Step 1: Call (contract-call? .core construct .core-bootstrap) to initialize the project by membership-token, proposal-submission, proposal-voting 

;; Step 2: Call (contract-call? .proposal-submission propose .proposal "Proposal Title" u"Your UTF-8 encoded proposal description here" u1440)

;; ######################################

(define-public (construct (proposal <proposal-trait>))
  (let
    (
      (sender tx-sender)
    )
    (asserts! (is-eq sender (var-get executive)) ERR_UNAUTHORIZED)
    (var-set executive (as-contract tx-sender))
    (as-contract (execute proposal sender))
  )
)

;; Reqest a call back

(define-public (request-extension-callback (extension <extension-trait>) (memo (buff 34)))
  (let
    (
      (sender tx-sender)
    )
    (asserts! (is-extension contract-caller) ERR_INVALID_EXTENSION)
    (asserts! (is-eq contract-caller (contract-of extension)) ERR_INVALID_EXTENSION)
    (as-contract (contract-call? extension callback sender memo))
  )
)