;; Property Registry Contract
(define-map properties
  { property-id: uint }
  {
    owner: principal,
    price-per-month: uint,
    available: bool,
    security-deposit: uint
  }
)

(define-data-var next-property-id uint u1)

(define-public (list-property (price-per-month uint) (security-deposit uint))
  (let ((property-id (var-get next-property-id)))
    (map-insert properties
      { property-id: property-id }
      {
        owner: tx-sender,
        price-per-month: price-per-month,
        available: true,
        security-deposit: security-deposit
      }
    )
    (var-set next-property-id (+ property-id u1))
    (ok property-id)
  )
)

(define-read-only (get-property (property-id uint))
  (map-get? properties { property-id: property-id })
)
