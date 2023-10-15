const WolfOwnership =  artifacts.require('WolfOwnership');

contract('WolfOwnership', () => {
    it('Should deploy smart conctract', async () => {
        const wolfOwnership = await WolfOwnership.deployed();
        assert(wolfOwnership.address !== '');
    });
});
