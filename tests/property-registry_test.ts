import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.0.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
  name: "Can list property",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const deployer = accounts.get("deployer")!;
    
    let block = chain.mineBlock([
      Tx.contractCall("property-registry", "list-property", 
        [types.uint(1000), types.uint(2000)], 
        deployer.address
      )
    ]);
    assertEquals(block.receipts[0].result.expectOk(), types.uint(1));
  },
});
