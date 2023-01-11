// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8.0;

import "./Position.sol";
import "../data/DataStore.sol";
import "../data/ListStore.sol";

/**
 * @title PositionStoreUtils
 * @dev Library for position storage functions
 */
library PositionStoreUtils {
    using Position for Position.Props;

    bytes32 public constant POSITION_KEYS = keccak256(abi.encode("POSITION_KEYS"));
    bytes32 public constant ACCOUNT_POSITION_KEYS = keccak256(abi.encode("ACCOUNT_POSITION_KEYS"));

    bytes32 public constant ACCOUNT = keccak256(abi.encode("ACCOUNT"));
    bytes32 public constant MARKET = keccak256(abi.encode("MARKET"));
    bytes32 public constant COLLATERAL_TOKEN = keccak256(abi.encode("COLLATERAL_TOKEN"));

    bytes32 public constant SIZE_IN_USD = keccak256(abi.encode("SIZE_IN_USD"));
    bytes32 public constant SIZE_IN_TOKENS = keccak256(abi.encode("SIZE_IN_TOKENS"));
    bytes32 public constant COLLATERAL_AMOUNT = keccak256(abi.encode("COLLATERAL_AMOUNT"));
    bytes32 public constant BORROWING_FACTOR = keccak256(abi.encode("BORROWING_FACTOR"));
    bytes32 public constant LONG_TOKEN_FUNDING_AMOUNT_PER_SIZE = keccak256(abi.encode("LONG_TOKEN_FUNDING_AMOUNT_PER_SIZE"));
    bytes32 public constant SHORT_TOKEN_FUNDING_AMOUNT_PER_SIZE = keccak256(abi.encode("SHORT_TOKEN_FUNDING_AMOUNT_PER_SIZE"));
    bytes32 public constant INCREASED_AT_BLOCK = keccak256(abi.encode("INCREASED_AT_BLOCK"));
    bytes32 public constant DECREASED_AT_BLOCK = keccak256(abi.encode("DECREASED_AT_BLOCK"));

    bytes32 public constant IS_LONG = keccak256(abi.encode("IS_LONG"));

    function get(DataStore dataStore, bytes32 key) internal view returns (Position.Props memory) {
        Position.Props memory position;

        position.setAccount(dataStore.getAddress(
            keccak256(abi.encode(key, ACCOUNT))
        ));

        position.setMarket(dataStore.getAddress(
            keccak256(abi.encode(key, MARKET))
        ));

        position.setCollateralToken(dataStore.getAddress(
            keccak256(abi.encode(key, COLLATERAL_TOKEN))
        ));

        position.setSizeInUsd(dataStore.getUint(
            keccak256(abi.encode(key, SIZE_IN_USD))
        ));

        position.setSizeInTokens(dataStore.getUint(
            keccak256(abi.encode(key, SIZE_IN_TOKENS))
        ));

        position.setCollateralAmount(dataStore.getUint(
            keccak256(abi.encode(key, COLLATERAL_AMOUNT))
        ));

        position.setBorrowingFactor(dataStore.getUint(
            keccak256(abi.encode(key, BORROWING_FACTOR))
        ));

        position.setLongTokenFundingAmountPerSize(dataStore.getInt(
            keccak256(abi.encode(key, LONG_TOKEN_FUNDING_AMOUNT_PER_SIZE))
        ));

        position.setShortTokenFundingAmountPerSize(dataStore.getInt(
            keccak256(abi.encode(key, SHORT_TOKEN_FUNDING_AMOUNT_PER_SIZE))
        ));

        position.setIncreasedAtBlock(dataStore.getUint(
            keccak256(abi.encode(key, INCREASED_AT_BLOCK))
        ));

        position.setDecreasedAtBlock(dataStore.getUint(
            keccak256(abi.encode(key, DECREASED_AT_BLOCK))
        ));

        position.setIsLong(dataStore.getBool(
            keccak256(abi.encode(key, IS_LONG))
        ));

        return position;
    }

    function set(DataStore dataStore, ListStore listStore, bytes32 key, Position.Props memory position) internal {
        listStore.addBytes32(
            POSITION_KEYS,
            key
        );

        listStore.addBytes32(
            getAccountPositionSetKey(position.account()),
            key
        );

        dataStore.setAddress(
            keccak256(abi.encode(key, ACCOUNT)),
            position.account()
        );

        dataStore.setAddress(
            keccak256(abi.encode(key, MARKET)),
            position.market()
        );

        dataStore.setAddress(
            keccak256(abi.encode(key, COLLATERAL_TOKEN)),
            position.collateralToken()
        );

        dataStore.setUint(
            keccak256(abi.encode(key, SIZE_IN_USD)),
            position.sizeInUsd()
        );

        dataStore.setUint(
            keccak256(abi.encode(key, SIZE_IN_TOKENS)),
            position.sizeInTokens()
        );

        dataStore.setUint(
            keccak256(abi.encode(key, COLLATERAL_AMOUNT)),
            position.collateralAmount()
        );

        dataStore.setUint(
            keccak256(abi.encode(key, BORROWING_FACTOR)),
            position.collateralAmount()
        );

        dataStore.setInt(
            keccak256(abi.encode(key, LONG_TOKEN_FUNDING_AMOUNT_PER_SIZE)),
            position.longTokenFundingAmountPerSize()
        );

        dataStore.setInt(
            keccak256(abi.encode(key, SHORT_TOKEN_FUNDING_AMOUNT_PER_SIZE)),
            position.shortTokenFundingAmountPerSize()
        );

        dataStore.setUint(
            keccak256(abi.encode(key, INCREASED_AT_BLOCK)),
            position.increasedAtBlock()
        );

        dataStore.setUint(
            keccak256(abi.encode(key, DECREASED_AT_BLOCK)),
            position.decreasedAtBlock()
        );

        dataStore.setBool(
            keccak256(abi.encode(key, IS_LONG)),
            position.isLong()
        );
    }

    function remove(DataStore dataStore, ListStore listStore, bytes32 key, address account) internal {
        listStore.removeBytes32(
            POSITION_KEYS,
            key
        );

        listStore.removeBytes32(
            getAccountPositionSetKey(account),
            key
        );

        dataStore.removeAddress(
            keccak256(abi.encode(key, ACCOUNT))
        );

        dataStore.removeAddress(
            keccak256(abi.encode(key, MARKET))
        );

        dataStore.removeAddress(
            keccak256(abi.encode(key, COLLATERAL_TOKEN))
        );

        dataStore.removeUint(
            keccak256(abi.encode(key, SIZE_IN_USD))
        );

        dataStore.removeUint(
            keccak256(abi.encode(key, SIZE_IN_TOKENS))
        );

        dataStore.removeUint(
            keccak256(abi.encode(key, COLLATERAL_AMOUNT))
        );

        dataStore.removeUint(
            keccak256(abi.encode(key, BORROWING_FACTOR))
        );

        dataStore.removeInt(
            keccak256(abi.encode(key, LONG_TOKEN_FUNDING_AMOUNT_PER_SIZE))
        );

        dataStore.removeInt(
            keccak256(abi.encode(key, SHORT_TOKEN_FUNDING_AMOUNT_PER_SIZE))
        );

        dataStore.removeUint(
            keccak256(abi.encode(key, INCREASED_AT_BLOCK))
        );

        dataStore.removeUint(
            keccak256(abi.encode(key, DECREASED_AT_BLOCK))
        );

        dataStore.removeBool(
            keccak256(abi.encode(key, IS_LONG))
        );
    }

    function getPositionCount(ListStore listStore) internal view returns (uint256) {
        return listStore.getBytes32Count(POSITION_KEYS);
    }

    function getPositionKeys(ListStore listStore, uint256 start, uint256 end) internal view returns (bytes32[] memory) {
        return listStore.getBytes32ValuesAt(POSITION_KEYS, start, end);
    }

    function getAccountPositionCount(ListStore listStore, address account) internal view returns (uint256) {
        return listStore.getBytes32Count(getAccountPositionSetKey(account));
    }

    function getAccountPositionKeys(ListStore listStore, address account, uint256 start, uint256 end) internal view returns (bytes32[] memory) {
        return listStore.getBytes32ValuesAt(getAccountPositionSetKey(account), start, end);
    }

    function getAccountPositionSetKey(address account) internal pure returns (bytes32) {
        return keccak256(abi.encode(ACCOUNT_POSITION_KEYS, account));
    }
}