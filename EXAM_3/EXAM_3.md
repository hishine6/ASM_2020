루비 거래
 
길동은 루비를 채굴하여 보석 도매상인 곱단에게 판매하는데, 루비 하나의 시세가는 이의 크기와 같다.

곱단은 나름대로 자신만의 독특한 루비 구매 방법이 있는데, 크기가 서로 같거나 다른 N 개의
 루비를 곱단에게 가져오면, 이 중 가장 작은 루비의 크기에 N을 곱한 값을 전체 루비
 가격으로 산정하여 지불한다.
예를 들어 크기가 각각 5, 2, 4인 세 개의 루비를 곱단에게 가져다 주면 곱단은 6원 밖에
 지불하지 않는다.
즉, 곱단은 가장 작은 루비의 가격을 다른 모든 루비의 가격으로 산정하는 것이다.
 
어느날 길동은 크기가 S1,S2,S3,...,SN 인  N 개의 루비를 채굴하였다.
이들 루비를 모두 곱단에게 가져다 주면 제 값을 못받는다는 것을 뻔히 알고 있기 때문에,
 길동은 이들의 일부만을 곱단에게 판매하여 가능한 많은 금액을 벌고 싶다.

과연 길동이 얼마나 많은 돈을 벌 수 있는지 계산하여 길동을 도와주자.
 
입력
 
- 아래 입출력 예에서 보인 것처럼 채굴한 루비의 크기를 빈칸으로 분리하여 한 줄로 입력한다.
- 입력 문자열의 크기는 최대 248로 빈칸과 정수 값들로 구성된다(<enter> 제외, 입력 오류는 없다)
- 루비의 개수는 1개 이상, 60개 이하라고 가정한다(즉, 한 줄에 입력되는 루비 무게는 최대 60이다).
- 루비 무게는 양의 정수로 주어지는데, 곱단은 이 무게를 해당 루비의 시세가로 본다.
- 모든 연산에 overflow가 생기지 않게 값이 입력된다고 가정한다. 즉, 32bit를 사용하면 충분.
- 입력되는 루비 무게는 무순서이다.
- 빈칸만 입력되는 경우는 없다.
- <enter>만 입력하면 프로그램을 종료한다.
 
출력
 
각 입력 대해 길동이 얻을 수 있는 최대 금액을 한줄에 하나씩 차례로 출력한다.
 
입출력 예
아래 예에서
- prompt 후 핑크 : 루비 크기 리스트 입력 후 <enter>
- prompt후 암것도 없으면 그냥 <enter>
- 갈색 : 얻을 수 있는 최대 이득
--------------------------------(이 줄 제외)
Q:\>s123456AQ3.exe
Enter Ruby Sizes :
15 10
Max Profit = 20
 
Enter Ruby Sizes :
1 5 4 2 3
Max Profit = 9
 
Enter Ruby Sizes :
2 7 3 9 5 10 8 4
Max Profit = 28
 
Enter Ruby Sizes :
 
Bye!
Q:\>
--------------------------------(이 줄 제외)
 
주의
 
- Max profit이 틀리면 점수가 없습니다.
- 출력 값이 정확해도 위 출력 예의 형태와 다른 경우 감점합니다
  (빈 줄, 빈 칸, 영문 철자, 대소문자, Bye! 등 조심하세요)

copy right -> Professor 임종석 from Sogang Univ