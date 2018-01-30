describe('object instantiation methods', function () {
  var obj, instance;

  describe('constuctor function', function () {
    beforeEach(function () {
      obj = function () {};
      instance = new obj();
    });

    it('has typeof', function () {
      expect(typeof instance).toBe("object");
    });
});
