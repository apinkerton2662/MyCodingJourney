# Switch can be easier to maintain than If statement
#and can provide additional features

Switch ($status) {
    0 { $status_text = 'ok' }
    1 { $status_text = 'error' }
    2 { $status_test = 'jammed' }
    3 { $status_test = 'overheated' }
    4 { $status_test = 'empty' }
    default { $status_text = 'unknown' }
}

$status_text = Switch ($status) {
    0 { 'ok' }
    1 { 'error' }
    2 { 'jammed' }
    3 { 'overheated' }
    4 { 'empty' }
    default { 'unknown' }
}
