import { personListService } from "@/api/person";

export const getPeople = async () => {
  try {
    const res = await personListService();
    if (res.code === 0) {
      return res.data;
    }
    else {
      throw Error('failed to get people');
    }
  }
  catch (error) {
    console.error(error);
  }
}

export const requiredRule = {
  required: true,
  message: 'this field cannot be blank', 
  trigger: 'blur'
}

export const posNumRule = {
  type: 'number',
  required: true,
  message: 'please enter a positive number',
  trigger: 'blur'
}

export const getDateString = (date) => {
  return new Date(date).toISOString().split('T')[0];
}