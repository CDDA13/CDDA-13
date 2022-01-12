import { useBackend } from '../backend';
import { Section } from '../components';
import { Window } from '../layouts';

export const Smes = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    capacityPercent,
    capacity,
    charge,
    inputAttempt,
    inputting,
    inputLevel,
    inputLevelMax,
    inputAvailable,
    outputAttempt,
    outputting,
    outputLevel,
    outputLevelMax,
    outputUsed,
  } = data;
  return (
    <Window
      width={700}
      height={700}>
      <Window.Content>
        <Section />
      </Window.Content>
    </Window>
  );
};
