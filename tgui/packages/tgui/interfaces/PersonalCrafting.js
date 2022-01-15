import { useBackend, useLocalState } from '../backend';
import { Section, Tabs, Input, Stack, Button, Box } from '../components';
import { Window } from '../layouts';

export const PersonalCrafting = (props, context) => {
  const { act, data } = useBackend(context);
  const [searchText, setSearchText] = useLocalState(context, 'searchText', "");
  const [currentRecipe, setCurrentRecipe] = useLocalState(context, 'currentRecipe');
  const {
    categories,
    category,
    recipes,
  } = data;

  const _recipes = recipes?.filter(
    (rec, _) => rec.name.search(searchText) >= 0);

  return (
    <Window
      width={700}
      height={500}>
      <Window.Content>
        <Section fill>
          <Tabs>
            <Stack wrap="wrap" textAlign="center">
              {categories
              && categories.map((cat, i) => (
                <Stack.Item key={cat}>
                  <Tabs.Tab
                    my={0.5}
                    selected={cat === category}
                    onClick={() => act('set_category', { category: cat })}>
                    {cat}
                  </Tabs.Tab>
                </Stack.Item>
              ))}
            </Stack>
          </Tabs>
          <Input
            fluid
            value={searchText}
            onInput={(e, value) => (
              setSearchText(value)
            )}
          />
          <Section title="">
            <Stack fill>
              <Stack.Item width="27%">
                <Stack vertical>
                  {_recipes && _recipes.map((rec, i) => (
                    <Stack.Item key={rec.id}>
                      <Button
                        fluid
                        selected={currentRecipe?.id === rec.id}
                        onClick={() => setCurrentRecipe(rec)}>
                        <Box verticalAlign="middle" mr={0.4} className={"crafting_buttons32x32 button-"+rec.button_icon} />
                        <Box textAlign="center" verticalAlign="middle" inline>{rec.name}</Box>
                      </Button>
                    </Stack.Item>
                  ))}
                </Stack>
              </Stack.Item>
              <Stack.Item>
                {currentRecipe && (<Box bold>{currentRecipe.name}</Box>)}
              </Stack.Item>
            </Stack>
          </Section>
        </Section>
      </Window.Content>
    </Window>
  );
};
