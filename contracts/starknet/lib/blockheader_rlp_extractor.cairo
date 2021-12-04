from starknet.lib.extract_from_rlp import extractData, extractElement, jumpOverElement, RLPElement

struct Keccak256Hash:
    member word_1 : felt
    member word_2 : felt
    member word_3 : felt
    member word_4 : felt
end

struct Address:
    member word_1 : felt
    member word_2 : felt
    member word_3 : felt
end

### Elements decoder 

func decode_parent_hash{ range_check_ptr }(block_rlp: felt*, block_rlp_len: felt) -> (res: Keccak256Hash):
    alloc_locals
    let (_, parent_hash) = extractData(4, 32, block_rlp, block_rlp_len)
    local hash: Keccak256Hash = Keccak256Hash(
        word_1=parent_hash[0],
        word_2=parent_hash[1],
        word_3=parent_hash[2],
        word_4=parent_hash[3]
    )
    return (hash)
end

func decode_uncles_hash{ range_check_ptr }(block_rlp: felt*, block_rlp_len: felt) -> (res: Keccak256Hash):
    alloc_locals
    let (_, uncles_hash) = extractData(4+32+1, 32, block_rlp, block_rlp_len)
    local hash: Keccak256Hash = Keccak256Hash(
        word_1=uncles_hash[0],
        word_2=uncles_hash[1],
        word_3=uncles_hash[2],
        word_4=uncles_hash[3]
    )
    return (hash)
end

func decode_beneficiary{ range_check_ptr }(block_rlp: felt*, block_rlp_len: felt) -> (res: Address):
    alloc_locals
    let (_, beneficiary) = extractData(4+32+1+32+1, 20, block_rlp, block_rlp_len)
    local address: Address = Address(
        word_1=beneficiary[0],
        word_2=beneficiary[1],
        word_3=beneficiary[2]
    )
    return (address)
end

func decode_state_root{ range_check_ptr }(block_rlp: felt*, block_rlp_len: felt) -> (res: Keccak256Hash):
    alloc_locals
    let (_, state_root) = extractData(4+32+1+32+1+20+1, 32, block_rlp, block_rlp_len)
    local hash: Keccak256Hash = Keccak256Hash(
        word_1=state_root[0],
        word_2=state_root[1],
        word_3=state_root[2],
        word_4=state_root[3]
    )
    return (hash)
end

func decode_transactions_root{ range_check_ptr }(block_rlp: felt*, block_rlp_len: felt) -> (res: Keccak256Hash):
    alloc_locals
    let (_, transactions_root) = extractData(4+32+1+32+1+20+1+32+1, 32, block_rlp, block_rlp_len)
    local hash: Keccak256Hash = Keccak256Hash(
        word_1=transactions_root[0],
        word_2=transactions_root[1],
        word_3=transactions_root[2],
        word_4=transactions_root[3]
    )
    return (hash)
end

func decode_receipts_root{ range_check_ptr }(block_rlp: felt*, block_rlp_len: felt) -> (res: Keccak256Hash):
    alloc_locals
    let (_, receipts_root) = extractData(4+32+1+32+1+20+1+32+1+32+1, 32, block_rlp, block_rlp_len)
    local hash: Keccak256Hash = Keccak256Hash(
        word_1=receipts_root[0],
        word_2=receipts_root[1],
        word_3=receipts_root[2],
        word_4=receipts_root[3]
    )
    return (hash)
end

func decode_difficulty{ range_check_ptr }(block_rlp: felt*, block_rlp_len: felt) -> (res: felt):
    alloc_locals
    let (local difficulty_rlp_element: RLPElement) = extractElement(block_rlp, block_rlp_len, 448)
    local difficulty = difficulty_rlp_element.element[0]
    return (difficulty)
end

func decode_block_number{ range_check_ptr }(block_rlp: felt*, block_rlp_len: felt) -> (res: felt):
    alloc_locals
    let (blockNumberPosition) = jumpOverElement(block_rlp, block_rlp_len, 448)
    let (local block_number_rlp_element: RLPElement) = extractElement(block_rlp, block_rlp_len, blockNumberPosition)
    local block_number = block_number_rlp_element.element[0]
    return (block_number)
end