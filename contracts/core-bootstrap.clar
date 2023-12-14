;; title: core-bootstrap
;; version: 0.1
;; summary: HiroHacks #2 Decentralized Grants Program
;; description: Discover decentralized funding with our guide on creating a DeGrant Program
;;              for token holders. Learn to establish a community-driven grant system, empowering token 
;;              holders to support innovative projects and foster collective progress.



(impl-trait .proposal-trait.proposal-trait)

(define-public (execute (sender principal))
    (begin
        ;; Enable genesis extensions individually
        (try! (contract-call? .core set-extension .membership-token true))
        (try! (contract-call? .core set-extension .proposal-submission true))
        (try! (contract-call? .core set-extension .proposal-voting true))

        ;; Mint initial token supply for each recipient
        (try! (contract-call? .membership-token mint u1000 sender))
        (try! (contract-call? .membership-token mint u1000 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5))
        (try! (contract-call? .membership-token mint u1000 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG))
        (try! (contract-call? .membership-token mint u1000 'ST2JHG361ZXG51QTKY2NQCVBPPRRE2KZB1HR05NNC))
        (try! (contract-call? .membership-token mint u1000 'ST2NEB84ASENDXKYGJPQW86YXQCEFEX2ZQPG87ND))
        (try! (contract-call? .membership-token mint u1000 'ST2REHHS5J3CERCRBEPMGH7921Q6PYKAADT7JP2VB))
        (try! (contract-call? .membership-token mint u1000 'ST3AM1A56AK2C1XAFJ4115ZSV26EB49BVQ10MGCS0))
        (try! (contract-call? .membership-token mint u1000 'ST3NBRSFKX28FQ2ZJ1MAKX58HKHSDGNV5N7R21XCP))
        (try! (contract-call? .membership-token mint u1000 'ST3PF13W7Z0RRM42A8VZRVFQ75SV1K26RXEP8YGKJ))
        (try! (contract-call? .membership-token mint u1000 'STNHKEPYEPJ8ET55ZZ0M5A34J0R3N5FM2CMMMAZ6))

        (print "DavyGrant's upward trajectory is unmistakable.")
        (ok true)
    )
)
