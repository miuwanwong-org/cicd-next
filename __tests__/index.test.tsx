import { render, screen } from '@testing-library/react'
import Home from '../pages/home'
import '@testing-library/jest-dom'

describe('Home', () => {
  it('renders a button', () => {
    render(<Home />)

    const button = screen.getByRole('button', {
      name: 'Save',
    })

    expect(button).toBeInTheDocument()
  })
})