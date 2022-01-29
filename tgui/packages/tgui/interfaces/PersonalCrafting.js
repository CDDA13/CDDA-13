import { Fragment } from 'inferno';
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
    _recipes,
  } = data;

  const recipes = _recipes?.filter(
    (recipe, _) => recipe.name.toLowerCase().search(
      searchText.toLowerCase()) >= 0);

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
          <Section fill title="">
            <Stack fill>
              <Stack.Item basis="30%">
                <Box overflowY="scroll" height="100%">
                  {recipes && recipes.map((recipe, i) => (
                    <Button
                      fluid
                      key={recipe.id}
                      selected={currentRecipe?.id === recipe.id}
                      onClick={() => setCurrentRecipe(recipe)}>
                      <Box
                        verticalAlign="middle"
                        mr={0.4}
                        className={"crafting_buttons32x32 button_small"
                        +recipe.button_icon} />
                      <Box
                        textAlign="center"
                        verticalAlign="middle"
                        inline>
                        {recipe.name}
                      </Box>
                    </Button>
                  ))}
                </Box>
              </Stack.Item>
              <Stack.Item grow basis="70%">
                {currentRecipe && (
                  <Fragment>
                    <Stack justify="space-between">
                      <Stack.Item grow>
                        <Box bold fontSize={1.5}>{currentRecipe.name}</Box>
                        <Box fontSize={1.2}>{currentRecipe.desc}
                        </Box>
                      </Stack.Item>
                      <Stack.Item>
                        <Box
                          className={"crafting_buttons96x96 button"
                          +currentRecipe.button_icon} />
                      </Stack.Item>
                    </Stack>
                    {currentRecipe.steps
                      && currentRecipe.steps.map((step, i) => (
                        <Box key={step} fontSize={1.3} my="1%">{step}</Box>
                      ))}
                    <Button onClick={() => act('start_recipe', { "recipe_id": currentRecipe.id })}>Start Recipe</Button>
                  </Fragment>
                )}
              </Stack.Item>
            </Stack>
          </Section>
        </Section>
      </Window.Content>
    </Window>
  );
};
