;; title: proposal-submission
;; version: 0.1
;; summary: HiroHacks #2 Decentralized Grants Program
;; description: Discover decentralized funding with our guide on creating a DeGrant Program
;;              for token holders. Learn to establish a community-driven grant system, empowering token 
;;              holders to support innovative projects and foster collective progress.


(impl-trait .extension-trait.extension-trait)
(use-trait proposal-trait .proposal-trait.proposal-trait)

(define-constant ERR_UNAUTHORIZED (err u3000))
(define-constant ERR_UNKNOWN_PARAMETER (err u3001))

(define-map parameters (string-ascii 34) uint)

(define-map proposals
  {proposal-id: uint}
  {
    title: (string-ascii 50),
    description: (string-utf8 500),
    proposer: principal,
    start-block-height: uint,
    end-block-height: uint
    ;; Add other fields as necessary
  }
)

(map-set parameters "proposal-duration" u1440) ;; ~10 days based on a ~10 minute block time.

;; Authorization Check

(define-public (is-dao-or-extension)
  (ok (asserts! (or (is-eq tx-sender .core) (contract-call? .core is-extension contract-caller)) ERR_UNAUTHORIZED))
)

;; 

(define-read-only (get-parameter (parameter (string-ascii 34)))
  (ok (unwrap! (map-get? parameters parameter) ERR_UNKNOWN_PARAMETER))
)

;; Proposals

(define-public (propose (proposal-id uint) (proposal <proposal-trait>) (title (string-ascii 50)) (description (string-utf8 500)) (proposal-duration uint))
    (let 
        (
            (start-block-height block-height)
            (end-block-height (+ block-height proposal-duration))
            (proposer tx-sender)
        )
        (begin
            ;; Store the proposal in the proposals map
            (map-set proposals
                {proposal-id: proposal-id}
                {
                    title: title,
                    description: description,
                    proposer: proposer,
                    start-block-height: start-block-height,
                    end-block-height: end-block-height
                    ;; Add other fields as necessary
                }
            )
            ;; Call the proposal-voting contract
            (contract-call? .proposal-voting add-proposal proposal 
                {
                    start-block-height: start-block-height, 
                    end-block-height: end-block-height, 
                    proposer: proposer, 
                    title: title, 
                    description: description
                }
            )
        )
    )
)






(define-public (callback (sender principal) (memo (buff 34)))
  (ok true)
)