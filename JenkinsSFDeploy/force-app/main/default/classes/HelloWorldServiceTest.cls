@isTest
private class HelloWorldServiceTest {
    @isTest
    static void testGetGreeting() {
        String name = 'John';
        String result = HelloWorldService.getGreeting(name);
        System.assertEquals('Hello, John!', result, 'Greeting should match expected output');
    }
}