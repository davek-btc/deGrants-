# README

Fork of starter package for the Hiro Hacks series.

## Getting Started

Taking the following steps:

Step 1: Call ->
(contract-call? .core construct .core-bootstrap) to initialize the project by membership-token, proposal-submission, proposal-voting 

Step 2: Call ->
(contract-call? .proposal-submission propose .proposal "Proposal Title" u"Your UTF-8 encoded proposal description here" u1440)

Step 3: Call-> 
(contract-call? .membership-token get-name)
(contract-call? .membership-token get-symbol)
(contract-call? .membership-token get-decimals)
(contract-call? .membership-token get-total-supply)
(contract-call? .membership-token get-token-uri)
(contract-call? .membership-token get-balance tx-sender)
