class Helper {
  Future mockService([dynamic error]) {
    print("Waiting");
    return new Future.delayed(const Duration(seconds: 60), () {
      if (error != null) {
        throw error;
      }
    });
  }
}
