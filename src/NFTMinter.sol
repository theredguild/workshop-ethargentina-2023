// SPDX-License-Identifier: SEE LICENSE IN LICENSE
/**
 * @title NFTMinter.
 * @author theredguild.
 * @notice theredguild.org
 * 
 * Objetivo:
 * Desarrollar un contrado llamado `NFTMinter` que permita lo siguiente.
    - mintear 1 NFT (`mintOne`).
    - retirar todo el ether depositado (`sweepFunds`)
    - la posibilidad de comprar más de 1 NFT en bulk/simultáneo
      (`mintMany(amount)`), con un límite de 10.
    - la posibilidad de mintear 1 NFT gratis (`mintFree`) dada la condición de
      que el usuario posea más de 10 puntos (1 mint de NFT == 1 punto).
    - la posibilidad de mintear 1 NFT gratis dada otra condición (`mintDeluxe`)
      determinada por la siguiente fórmula:
      (puntosUsuario / nftsMinteadosTotales * 100 > 20).

 */

pragma solidity ^0.8.17;

import "./MiNFT.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "forge-std/console.sol";

// errores sugeridos
error InsufficientPayment();
error NotEnoughPoints();
error AlreadyClaimed();
error MustMintFirst();
error AboveMintLimit();
error MustMintOneAtLeast();

contract NFTMinter {
    event ClaimedFree(address owner, uint256 tokenId, uint256 points);

    using Address for address payable;

    uint256 public immutable PRICE_TO_PAY;
    uint8 public immutable PRIZE_THRESHOLD;
    uint256 public immutable MINT_LIMIT;

    mapping(address => uint256) public points;
    mapping(address => bool) public claimed;

    MiNFT public nft;
    address public owner;

    /**
     * Constructor. Inicializa dos constantes
     * @param _price Precio base de 1 NFT
     * param _prize Cantidad mínima de NFTs necesarias para reclamar premio.
     */
    constructor(uint256 _price, uint8 _prize) {
        nft = new MiNFT();
        PRICE_TO_PAY = _price;

        PRIZE_THRESHOLD = _prize;
        MINT_LIMIT = 10;
        owner = msg.sender;
    }

    /**
     * Mintea un NFT al caller que envíe ether suficiente para pagarlo.
     */
    function mintOne() public payable {
        if (msg.value < PRICE_TO_PAY) revert InsufficientPayment();
        if (msg.value > PRICE_TO_PAY) {
            payable(msg.sender).sendValue(msg.value - PRICE_TO_PAY);
            console.log(
                "Se le devuelve este monto %s a %s",
                msg.value - PRICE_TO_PAY,
                msg.sender
            );
        }
        nft.safeMint(msg.sender);
        points[msg.sender]++;
    }

    /**
     * Permite retirar todo el balance disponible al owner del contrato.
     */
    function sweepFunds() public {
        payable(owner).sendValue(address(this).balance);
    }

    /**
     * Mintea al caller la cantidad de NFTs que se indica por parámetro, con
       algunas restricciones. No se pueden mintear más de 10.
     * @param amount Cantidad de NFTs a mintear.
     */
    function mintMany(uint256 amount) public payable {
        if (amount > MINT_LIMIT) revert AboveMintLimit();
        if (msg.value < PRICE_TO_PAY) revert InsufficientPayment();
        if (msg.value > PRICE_TO_PAY * amount) {
            payable(msg.sender).sendValue(msg.value - PRICE_TO_PAY * amount);
            console.log(
                "Se le devuelve este monto %s a %s",
                msg.value - PRICE_TO_PAY * amount,
                msg.sender
            );
        }
        for (uint i = 0; i < amount; i++) {
            nft.safeMint(msg.sender);
            points[msg.sender]++;
        }
    }

    /**
     * Mintea un NFT gratuito para aquellos usuarios que cumplen con determinado
     * criterio. Si la cantidad de puntos es >= 10, permitir reclamar un NFT
     * gratuito por única vez.
     * Emitir evento ClaimedFree();
     * Utilizar AlreadyClaimed() y NotEnoughPoints();
     */
    function mintFree() public {
        if (points[msg.sender] < PRIZE_THRESHOLD) revert NotEnoughPoints();
        if (claimed[msg.sender]) revert AlreadyClaimed();
        claimed[msg.sender] = true;
        emit ClaimedFree(msg.sender, nft.getTotalMinted(), points[msg.sender]);
        nft.safeMint(msg.sender);
        
    }

    /**
     * Mintea un NFT gratuito para aquellos usuarios que cumplen con determinado
     * criterio. Si la cantidad de puntos actuales representa más del 20% de la
     * cantidad actual, mintear dos NFTs de manera gratuita por única vez.
     * Reutilizar lógica de mintFree.
     */
    function mintFreeDeluxe() public returns (bool) {
        if (claimed[msg.sender]) revert AlreadyClaimed();
        if ((points[msg.sender] * 100) / nft.getTotalMinted() > 20) {
            nft.safeMint(msg.sender);
            emit ClaimedFree(msg.sender, nft.getTotalMinted(), points[msg.sender]);
            return true;
        }

        return false;
    }
}